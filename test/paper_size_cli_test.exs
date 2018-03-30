defmodule PaperSize.CLITest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias PaperSize.CLI

  describe "parse format" do
    test "valid format" do
      assert CLI.parse_format("a0") == {:a, 0}
      assert CLI.parse_format("B10") == {:b, 10}
      assert CLI.parse_format("c") == {:c, :all}
    end

    test "invalid format" do
      assert CLI.parse_format("a11") == "a11"
      assert CLI.parse_format("d") == "d"
      assert CLI.parse_format("44") == "44"
    end
  end

  describe "put paper size" do
    test "valid parameter" do
      output = capture_io(fn -> CLI.puts_paper_size({:a, 4}) end)
      assert output == "    A4 = height 297 mm x width 210 mm\n"
    end

    test "invalid paramater" do
      output = capture_io(fn -> CLI.puts_paper_size("xxx") end)
      assert output == "    xxx   unknown peper type\n"
    end
  end

  describe "command line parameters" do
    test "a3 b4 c5 x10" do
      assert capture_io(fn ->
               CLI.main(~w(a3 b4 c5 x10))
             end) == """
                 A3 = height 420 mm x width 297 mm
                 B4 = height 353 mm x width 250 mm
                 C5 = height 229 mm x width 162 mm
                 x10   unknown peper type
             """
    end
  end
end
