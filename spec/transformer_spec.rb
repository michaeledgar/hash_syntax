require_relative 'spec_helper'

describe HashSyntax::Transformer do
  describe 'transforming from 1.8 to 1.9 syntax' do
    it 'can transform a simple hash' do
      'x = {:foo => :bar}'.should transform_to('x = {foo: :bar}', :"to-19")
    end

    it 'transforms all hashes in a block of code' do
      input = %q{
with_jumps_redirected(:break => ensure_body[1], :redo => ensure_body[1], :next => ensure_body[1],
                      :return => ensure_body[1], :rescue => ensure_body[1],
                      :yield_fail => ensure_body[1]) do
  rescue_target, yield_fail_target =
      build_rescue_target(node, result, rescue_body, ensure_block,
                          current_rescue, current_yield_fail)
  walk_body_with_rescue_target(result, body, body_block, rescue_target, yield_fail_target)
end
}
      output = %q{
with_jumps_redirected(break: ensure_body[1], redo: ensure_body[1], next: ensure_body[1],
                      return: ensure_body[1], rescue: ensure_body[1],
                      yield_fail: ensure_body[1]) do
  rescue_target, yield_fail_target =
      build_rescue_target(node, result, rescue_body, ensure_block,
                          current_rescue, current_yield_fail)
  walk_body_with_rescue_target(result, body, body_block, rescue_target, yield_fail_target)
end
}
      input.should transform_to(output, :"to-19")
    end

    it 'transforms all hashes in a block of code without minding tight spacing' do
      input = %q{
with_jumps_redirected(:break=>ensure_body[1], :redo=>ensure_body[1], :next=>ensure_body[1],
                      :return=>ensure_body[1], :rescue=>ensure_body[1],
                      :yield_fail=>ensure_body[1]) do
  rescue_target, yield_fail_target =
      build_rescue_target(node, result, rescue_body, ensure_block,
                          current_rescue, current_yield_fail)
  walk_body_with_rescue_target(result, body, body_block, rescue_target, yield_fail_target)
end
}
      output = %q{
with_jumps_redirected(break:ensure_body[1], redo:ensure_body[1], next:ensure_body[1],
                      return:ensure_body[1], rescue:ensure_body[1],
                      yield_fail:ensure_body[1]) do
  rescue_target, yield_fail_target =
      build_rescue_target(node, result, rescue_body, ensure_block,
                          current_rescue, current_yield_fail)
  walk_body_with_rescue_target(result, body, body_block, rescue_target, yield_fail_target)
end
}
      input.should transform_to(output, :"to-19")
    end

  end

  describe 'transforming from 1.9 to 1.8 syntax' do
    it 'can transform a simple hash' do
      'x = {foo: :bar}'.should transform_to('x = {:foo => :bar}', :"to-18")
    end

    it 'transforms all hashes in a block of code' do
      input = %q{
with_jumps_redirected(break: ensure_body[1], redo: ensure_body[1], next: ensure_body[1],
                      return: ensure_body[1], rescue: ensure_body[1],
                      yield_fail: ensure_body[1]) do
  rescue_target, yield_fail_target =
      build_rescue_target(node, result, rescue_body, ensure_block,
                          current_rescue, current_yield_fail)
  walk_body_with_rescue_target(result, body, body_block, rescue_target, yield_fail_target)
end
}
      output = %q{
with_jumps_redirected(:break => ensure_body[1], :redo => ensure_body[1], :next => ensure_body[1],
                      :return => ensure_body[1], :rescue => ensure_body[1],
                      :yield_fail => ensure_body[1]) do
  rescue_target, yield_fail_target =
      build_rescue_target(node, result, rescue_body, ensure_block,
                          current_rescue, current_yield_fail)
  walk_body_with_rescue_target(result, body, body_block, rescue_target, yield_fail_target)
end
}
      input.should transform_to(output, :"to-18")
    end
  end
end
