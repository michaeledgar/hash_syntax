# hash_syntax

In Ruby 1.9, you can write a hash with symbol keys in two ways:

    { :foo => bar }
    { foo: bar }

Some have [expressed discontent](http://logicalfriday.com/2011/06/20/i-dont-like-the-ruby-1-9-hash-syntax/)
at this syntax change. Luckily, it's purely syntax sugar: there's no reason other than preference to
use one or the other (assuming you are targeting 1.9). That means we can freely convert between them!
That's what hash_syntax does: it scans Ruby code and turns the code into all 1.8 syntax or all 1.9 syntax.

## Using hash_syntax

To convert a whole project to 1.8 syntax:

    hash_syntax --to-18

To convert a whole project to 1.9 syntax:

    hash_syntax --to-19

With no arguments, hash_syntax will scan the following paths using `Dir[]` and operate on
each matching file:

* `app/**/*.rb`
* `ext/**/*.rb`
* `features/**/*.rb`
* `lib/**/*.rb`
* `spec/**/*.rb`
* `test/**/*.rb`

If you wish to convert individual files, you can name them explicitly:

    hash_syntax --to-19 lib/foo.rb

That's all there is to it!

## How it works

`hash_syntax` uses the [`object_regex` library](http://carboni.ca/blog/p/Regex-Search-on-Arbitrary-Sequences)
([source](https://github.com/michaeledgar/object_regex/)) to perform regex searches on the Ruby token
stream of a given file. A Ruby 1.8 symbol hash key which can be converted to 1.9's syntax can be described as:

    symbeg (ident | kw) sp? hashrocket

By using each token's unique name, (with one tweak: all other operators are `op` and the hashrocket is `hashrocket`),
object_regex can search using this pattern and find it in the Ruby source. Conveniently, you cannot have a line break
between the symbol and the hashrocket; otherwise, the regex would be a bit more complicated (also needing to consider
comments!). Each match is replaced inline as text, and `hash_syntax` notes how much the line has shrunk, in case further
replacements happen on the same line. A better option would be to replace the actual tokens in the stream and reconstruct
the source from the token stream.

Ruby 1.9 symbol tokens are just a single `label` token; they are easy to find in the source.

## Installation

    gem install hash_syntax

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Michael Edgar. See LICENSE for details.
