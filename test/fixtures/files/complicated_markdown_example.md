# Testing Syntax Highlighting

Here's some ruby.

```ruby
require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Exalog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
```

Here's some javascript

```javascript
import { Controller } from "@hotwired/stimulus"
import hljs from 'highlight.js';

export default class extends Controller {
  connect() {
    this.element.querySelectorAll("code, pre").forEach((el) => {
      const lang = el.getAttribute("language")
      console.log(lang, el)
      if (lang) {
        hljs.highlightElement(el, { language: lang });
      }
    });
  }
}
```

And, for now, we'll just add in a little SQL

```sql
SELECT * FROM users
  WHERE id IN (SELECT user_id FROM admin_users);
```

And this is a line with an inline code example: <code class="language-ruby">puts 'Hello world!'</code>.
