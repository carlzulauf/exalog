# Markdown Highlighting

This is an example document to test/demonstrate the markdown parsing/rendering and syntax highlighting capabilities of exalog's GFM (Github Flavored Markdown) support.

## Text formating

We need some relatively long lines of text, multiple paragraphs, and some things like quotes and lists to make sure all of that is rendered alright. We should also have some examples of *italics* and **bolds** in a few contexts. Can we do __underline__ in markdown still?

This is another paragraph. It doesn't really say much, but should be properly spaced below the paragraph above. Random link back to [blog home](https://exalog.mrks.io).

Here's an unordered list of things:

* This list actually has an order
* It's not like the order of these changes
* They are static list items
* They can't move on their own
* So, highly ordered
* But, there are no numbers
* We call numbers order
* *shrug*

Now, he's an ordered list:

1. This list has structure
2. It has order
3. ... but most importantly
4. It has numbers
5. I'm on row 5
6. You already knew that
7. because of the numbers

## Code blocks and highlighting

Code blocks can be `inline` or like the blocks below. Only the block form gets syntax highlighting.

Here's some javascript:

```js
document.getElementById('rearEnd').doFart(); // uh oh
```

Here's some ruby:

```ruby
def a_method
  puts "Hello, #{caller.join(', ')}" # bad idea
end
```
