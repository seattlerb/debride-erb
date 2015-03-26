require "minitest/autorun"
require "debride_erb"

module TestDebride; end

class TestDebride::TestErb < Minitest::Test
  def test_process_erb
    sexp = Debride.new.process_erb "test/file.erb"

    exp = s(:block,
            s(:lasgn, :_buf, s(:str, "")),
            s(:call, s(:lvar, :_buf), :<<, s(:str, "woot")),
            s(:call, s(:lvar, :_buf), :to_s))

    assert_equal exp, sexp
  end
end
