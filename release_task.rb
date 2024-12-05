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
require "yaml"

class ReleaseTask
  include Rake::DSL

  def initialize(product, jekyll_path)
    @product = product
    @product_id = product.downcase
    @jekyll_path = jekyll_path
    @jekyll_config = load_jekyll_config
    @version = detect_version
    @release_date = detect_release_date
  end

  def define
    define_generate_blog_task
  end

  private

  def load_jekyll_config
    YAML.safe_load_file(File.join(@jekyll_path, "_config.yml"), permitted_classes: [Date])
  end

  def detect_version
    @jekyll_config["#{@product_id}_version"]
  end

  def detect_release_date
    @jekyll_config["#{@product_id}_release_date"]
  end

  def define_generate_blog_task
    namespace :release do
      namespace :blog do
        desc "Generate release announce posts from a release note"
        task :generate do
          generate_blog_posts
        end
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
title: #{@product} #{@version}リリース
description: #{@product} #{@version}をリリースしました！
---

## #{@product} #{@version}リリース

#{@product} #{@version}をリリースしました！

それぞれの環境毎のインストール方法は、[インストール](/ja#{product_install_url})をご確認ください。

主な変更点は、[リリースノート](/ja#{product_release_note_url})をご確認ください。
    CONTENT
  end

  def post_content_en
    <<-CONTENT
---
layout: post.en
title: #{@product} #{@version} has been released
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
end
