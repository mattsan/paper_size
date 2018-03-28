defmodule PaperSize.CLITest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias PaperSize.CLI

  describe "parse arg" do
    test "valid arg" do
      assert CLI.parse_arg("a3") == {:a, 3}
      assert CLI.parse_arg("A4") == {:a, 4}
    end

    test "invalid arg" do
      assert CLI.parse_arg("a") == "a"
      assert CLI.parse_arg("44") == "44"
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
