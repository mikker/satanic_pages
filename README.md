<center><img src="https://s3.brnbw.com/Artboard-GDaMBcpYEJ.png" alt="Satanic Pages" width=762 /></center>

Static Markdown pages with YAML frontmatter and inline Erb, embedded in your Rails app.

As simple as, …  
**`app/views/pages/exorcism_tips.html.md`:**

```markdown
---
title: 3 tips for the PERFECT exorcism
author: Beelzebub
tags:
- listicles
- devil worship
- activity ideas
---
By <%= data.author %>.

Through trial and error, I've found that the perfect exorcism
starts with a refreshing drink.

Tagged <%= render "tag_list", tags: data.tags %>:

## Devilishly good lemonade recipe

…
```

## Usage

In `app/views/layouts/pages.html.erb`:

```ruby
<%= render_layout "application" do %>
  <h1><%= data.title %></h1>
  <article>
    <%= yield %>
  </article>
<% end %>
```

## Installation
Add this line to your application's Gemfile:

```sh
$ bundle add satanic_pages
$ bundle install
```

Add the _Concern_ to a regular controller:

```ruby
class PagesController < ApplicationController
  include SatanicPages::Controller
end
```

And set up a wildcard route:

```ruby
get("*page", to: "pages#show", as: :page, constraints: PagesController.constraint)
```

## License
[MIT](https://opensource.org/licenses/MIT)
