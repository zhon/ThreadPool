require "test_helper"

require 'threadpool'
require 'rantly'
require 'rantly/minitest_extensions'


describe ThreadPool do

  it 'will create thread_count number of threads' do
    threads = Set.new
    t_counter = -> { sleep 0.001; threads << Thread.current }
    tp = ThreadPool.new(3)
    3.times do
      tp << t_counter
    end
    tp.process
    tp.finish
    _(threads.size).must_equal 3
  end

  it '@queue must contain an item after being pushed' do
    tp = ThreadPool.new(1)
    assert_equal 0, tp.instance_variable_get(:@queue).size
    tp.push -> {}
    assert_equal 1, tp.instance_variable_get(:@queue).size
    tp.process
    tp.finish
  end

  it '@thread[0] must be dead after finishing' do
    tp = ThreadPool.new(1)
    tp.process
    assert tp.instance_variable_get(:@threads)[0].alive?
    tp.finish
    refute tp.instance_variable_get(:@threads)[0].alive?
  end

  it 'does nothing with nothing added' do
    tp = ThreadPool.new(1)
    tp.process
    tp.finish
  end

  it 'executes whatever is pushed' do
    x = 0
    tp = ThreadPool.new(1)
    tp.process
    tp.push -> { x += 1 }
    tp.finish
    assert_equal 1, x
  end

  it 'executes 2 items pushed' do
    x,y = 0,''
    tp = ThreadPool.new(2)
    tp.push -> { y << 'hello' }
    tp.push -> { x += 1 }
    tp.process
    tp.finish
    assert_equal 1, x
    assert_equal 'hello', y
  end

  it 'will execute in parallel' do
    property_of {
      range 2, 100
    }.check {|tc|
      tp = ThreadPool.new(tc)
      tc.times do
        tp.push -> { sleep 1.0/1000 }
      end
      t = Time.now.to_f
      tp.process
      tp.finish
      assert_in_delta t+1.0/1000, Time.now.to_f, tc * 0.3/1000, "Thread count #{tc}"
    }
  end

  ############ Property based TDD

  it 'with 0 threads all items complete' do
    skip
    test_q = Queue.new
    tp = ThreadPool.new(0)
    5.times do
      tp.push -> { test_q << 1 }
    end
    tp.process
    assert_equal 5, test_q.length
  end

  it 'with mutiple threads all items run in parallel' do
  end

  it 'with mutiple threads all items complete' do
  end

end

