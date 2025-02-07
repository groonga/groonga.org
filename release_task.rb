# Copyright (C) 2024  Kodama Takuya <otegami@clear-code.com>
# Copyright (C) 2024  Horimoto Yasuhiro <horimoto@clear-code.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

require "date"
require "json"
require "open-uri"
require "yaml"

class ReleaseTask
  class GitHubClient
    def initialize(user, repository)
      @user = user
      @repository = repository
    end

    def latest_release
      api_uri("releases").open do |input|
        JSON.parse(input.read)[0]
      end
    end

    def latest_tag
      api_uri("tags").open do |input|
        JSON.parse(input.read)[0]
      end
    end

    def tag_commit(tag)
      URI(tag["commit"]["url"]).open do |input|
        JSON.parse(input.read)
      end
    end

    private
    def api_uri(path)
      URI("https://api.github.com/repos/#{@user}/#{@repository}/#{path}")
    end
  end

  include Rake::DSL

  def initialize(product, jekyll_path)
    @product = product
    @product_id = product.downcase
    @jekyll_path = jekyll_path
    @jekyll_config_path = File.join(@jekyll_path, "_config.yml")
    @jekyll_config = load_jekyll_config
    @version = detect_version
    @release_date = detect_release_date
  end

  def define
    namespace :release do
      define_generate_blog_task
      define_version_update_task
    end
  end

  private
  def load_jekyll_config
    YAML.safe_load_file(@jekyll_config_path, permitted_classes: [Date])
  end

  def detect_version
    @jekyll_config["#{@product_id}_version"]
  end

  def detect_release_date
    @jekyll_config["#{@product_id}_release_date"]
  end

  def define_generate_blog_task
    namespace :blog do
      desc "Generate release announce posts"
      task :generate do
        generate_blog_posts
      end
    end
  end

  def post_filename
    "#{@release_date.strftime("%F")}-#{@product_id}-#{@version}.md"
  end

  def product_install_url
    "/docs/install.html"
  end

  def product_release_note_url
    major_version = @version.split(".")[0]
    "/docs/news/#{major_version}.html#release-#{@version.gsub(".", "-")}"
  end

  def post_content_ja
    <<-CONTENT
---
layout: post.ja
title: #{@product} #{@version}リリース！
description: #{@product} #{@version}をリリースしました！
---

## #{@product} #{@version}リリース

#{@product} #{@version}をリリースしました！

それぞれの環境毎のインストール方法は、[インストール](/ja#{product_install_url})をご確認ください。

主な変更点は、[リリースノート](/ja#{product_release_note_url})をご確認ください。

開発者がGroonga・PGroonga・Mroongaのリリース内容について自慢する動画配信、[Groonga リリース自慢会](https://www.youtube.com/playlist?list=PLLwHraQ4jf7PnA3GjI9v90DZq8ikLk0iN)もあわせてご覧ください。
    CONTENT
  end

  def post_content_en
    <<-CONTENT
---
layout: post.en
title: #{@product} #{@version} has been released!
description: #{@product} #{@version} has been released!
---

## #{@product} #{@version} has been released

#{@product} #{@version} has been released!

For installation instructions on your environments, please see the [Installation Guide](#{product_install_url}).

For the information on the changes in this release, please see the [Release Note](#{product_release_note_url}).
    CONTENT
  end

  def generate_blog_posts
    ["ja", "en"].each do |locale|
      File.open("#{@jekyll_path}/#{locale}/_posts/#{post_filename}", "w") do |post|
        post.write(__send__("post_content_#{locale}"))
      end
    end
  end

  def define_version_update_task
    namespace :version do
      desc "Update version"
      task :update do
        github_client = GitHubClient.new(@product, @product)
        latest_tag = github_client.latest_tag
        tag_commit = github_client.tag_commit(latest_tag)
        # "v14.1.3"(Groonga), "v14.14"(Mroonga) or "3.2.5"(PGroonga)
        release_tag_name = latest_tag["name"]
        # "14.1.3", "14.14" or "3.2.5"
        latest_version = release_tag_name[/\d+(\.\d+){1,2}/, 0]
        # "2025-01-29T15:00:00Z(UTC)" -> "2025-01-30(JST)"
        latest_release_date = Time.parse(tag_commit["commit"]["committer"]["date"])
                                  .getlocal("+09:00")
                                  .strftime("%Y-%m-%d")
        jekyll_config = File.read(@jekyll_config_path)
        escaped_product_id = Regexp.escape(@product_id)
        jekyll_config.gsub!(/^(#{escaped_product_id}_version: ).+$/) do
          "#{$1}\"#{latest_version}\""
        end
        jekyll_config.gsub!(/^(#{escaped_product_id}_release_date: ).+$/) do
          "#{$1}#{latest_release_date}"
        end
        File.write(@jekyll_config_path, jekyll_config)
        sh("git", "add", @jekyll_config_path)
        message = "#{@product} #{latest_version} has been released!!!"
        sh("git", "commit", "-m", message)
        sh("git", "tag", "-a", latest_version, "-m", message)
        sh("git", "push")
        sh("git", "push", "--tags")
      end
    end
  end
end
