source "https://rubygems.org"

# Hello! This is where you manage which Jekyll version is used to run.
# When you want to use a different version, change it below, save the
# file and run `bundle install`. Run Jekyll with `bundle exec`, like so:
#
#     bundle exec jekyll serve
#
# This will help ensure the proper Jekyll version is running.
# Happy Jekylling!
gem "jekyll", "~> 4.4"

# This is the default theme for new Jekyll sites. You may change this to anything you like.
gem "minima", "~> 2.0"

# ActiveSupport for security compliance
gem "activesupport", "6.1.7.5"

# If you want to use GitHub Pages, remove the "gem "jekyll"" above and
# uncomment the line below. To upgrade, run `bundle update github-pages`.
#gem "github-pages", "~> 232", group: :jekyll_plugins

# 만약 github-pages 를 사용하지 않는다면 so-simple-theme gem을 직접 추가해야 함
gem "jekyll-theme-so-simple"

# If you have any plugins, put them here!
group :jekyll_plugins do
  gem "jekyll-seo-tag"
  gem "jekyll-sitemap"
  gem "jekyll-feed", "~> 0.6"
  gem "jekyll-paginate"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.1" if Gem.win_platform?
