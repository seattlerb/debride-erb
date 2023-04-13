require "minitest/autorun"
require "debride_erb"

module TestDebride; end

class TestDebride::TestErb < Minitest::Test
  make_my_diffs_pretty!

  def test_process_erb
    sexp = Debride.new.process_erb "test/file.erb"

    exp = s(:block,
            s(:lasgn, :_buf, s(:call, s(:colon3, :String), :new)),
            s(:attrasgn, s(:lvar, :_buf), :safe_append=, s(:str, "woot ")),
            s(:attrasgn, s(:lvar, :_buf), :append=,      s(:lit, 42)),
            s(:attrasgn, s(:lvar, :_buf), :safe_append=, s(:str, "\n")),
            s(:call, s(:lvar, :_buf), :to_s))

    assert_equal exp, sexp
  end

  def test_process_block
    sexp = Debride.new.process_erb "test/block.erb"

    exp = s(:block,
            s(:lasgn, :_buf, s(:call, s(:colon3, :String), :new)),
            s(:attrasgn, s(:lvar, :_buf), :append=,
              s(:iter,
                s(:call, nil, :block_call, s(:lit, 1), s(:lit, 2)),
                s(:args, :f),
                s(:attrasgn, s(:lvar, :_buf), :safe_append=, s(:str, "\nwoot?\n")))),
            s(:call, s(:lvar, :_buf), :to_s))

    assert_equal exp, sexp
  end
end
