<center><img src="https://s3.brnbw.com/Artboard-GDaMBcpYEJ.png" alt="Satanic Pages" width=762 /></center>

Static pages with YAML frontmatter, embedded in your Rails app.

Simple as the devil, like…

**`app/views/pages/exorcism_tips.html.md`:**

```markdown
---
title: 3 tips for the PERFECT exorcism
tags:
- listicles
- devil worship
- activity ideas
---
Through trial and error, I've found that the perfect exorcism starts with a refreshing drink.

## Devilishly good lemonade recipe

...
```

## Usage

```ruby
# config/routes.rb

# ...
get("*page", to: "pages#show", as: :page, constraints: PagesController.constraint)
# ...
```

```ruby
class PagesController < ApplicationController
  include SatanicPages::Controller
end
```

In `app/views/layouts/pages.html.erb`:

```
<%= render_layout "application" do %>
  <h1><%= current_page.title %></h1>
  <article>
    <%= yield %>
  </article>
<% end %>
```

## Installation
Add this line to your application's Gemfile:

```sh
$ bundle add satanic_pages
$ bundle add markdown-rails # optional, but probably
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
