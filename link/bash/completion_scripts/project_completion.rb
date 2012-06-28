#!/usr/bin/env ruby

class ProjectCompletion
  def initialize(search_dir, command_line)
    @root = search_dir.sub('~', ENV['HOME'])
    @typed = command_line.split(/\s+/,2).last
  end
  
  def matches
    Dir.chdir @root do
      Dir["#{@typed}*"].select { |name| File.directory? name }.map { |name| "#{name}/" }
    end
  end
end

if (__FILE__ == $0)
  require 'test/unit'
  
  class ProjectCompletionTest < Test::Unit::TestCase
    DOTFILES = '~/.dotfiles'

    def test_init
      assert_not_nil ProjectCompletion.new(DOTFILES, 'p ')
    end

    def test_finds_dirs_in_top
      matches = ProjectCompletion.new(DOTFILES, 'p ').matches
      #raise matches.inspect
      assert_include 'link/', matches
      assert_include 'copy/', matches
    end

    def test_does_not_find_files_in_top
      matches = ProjectCompletion.new(DOTFILES, 'p ').matches
      assert_nil matches.index('README')
    end

    def test_finds_matching_dirs
      matches = ProjectCompletion.new(DOTFILES, 'p l').matches
      assert_include 'link/', matches
      assert_not_include 'copy/', matches
    end

    def test_finds_dirs_in_child
      matches = ProjectCompletion.new(DOTFILES, 'p link/').matches
      assert_include 'link/bash/', matches
      assert_include 'link/vim/', matches
    end

    def test_finds_matching_dirs_in_child
      matches = ProjectCompletion.new(DOTFILES, 'p link/b').matches
      assert_include 'link/bash/', matches
      assert_not_include 'link/vim/', matches
    end


    def assert_include (element, ary)
      assert_not_nil ary.index(element), "#{ary.inspect} does not include #{element.inspect}"
    end

    def assert_not_include (element, ary)
      assert_nil ary.index(element), "#{ary.inspect} includes #{element.inspect}"
    end
    
  end
end
