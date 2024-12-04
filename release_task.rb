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

require "yaml"
require "date"

class ReleaseTask
  include Rake::DSL

  def initialize(package, jekyll_path)
    @package = package
    @version = detect_version
    @jekyll_path = jekyll_path
  end

  def define
    define_generate_blog_task
  end

  private

  def jekyll_config
    YAML.safe_load_file("_config.yml", permitted_classes: [Date])
  end

  def detect_version
    jekyll_config["#{@package.downcase}_version"]
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
    "#{Time.now.strftime("%F")}-#{@package.downcase}-#{@version}.md"
  end

  def post_content(locale)
    # TODO: We will write blog post contents here.
    # After writing contents, we will remove this TODO comment.
    "#{locale}, #{@package}, #{@version}"
  end

  def generate_blog_posts
    ["ja", "en"].each do |locale|
      File.open("#{@jekyll_path}/#{locale}/_posts/#{post_filename}", "w") do |post|
        post.write(post_content(locale))
      end
    end
  end
end
