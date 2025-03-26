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

require "erb"

require_relative "release_task"

release_task = ReleaseTask.new("Groonga", __dir__)
release_task.define

namespace :pgroonga do
  namespace :release do
    namespace :blog do
      desc "Generate release announce posts"
      task :generate do
        client = ReleaseTask::GitHubClient.new("pgroonga", "pgroonga")
        latest_release = client.latest_release
        # "PGroonga 3.2.4: 2024-10-03"
        release_name = latest_release["name"]
        # "3.2.4"
        version = release_name[/\d+\.\d+\.\d+/, 0]
        # "2024-10-03"
        release_date = Date.parse(release_name[/\d+-\d+-\d+/, 0])

        post_md = "#{release_date.strftime("%F")}-pgroonga-#{version}.md"
        ["ja", "en"].each do |locale|
          base_url = "https://pgroonga.github.io"
          product_label = "PGroonga"
          news_path = "/news/\#version-#{version.gsub(".", "-")}"
          template_path = "_templates/#{locale}/_posts/pgroonga-release.md"
          case locale
          when "ja"
            base_url += "/ja"
            product_full_label =
              "PostgreSQL用ゼロETL高速日本語全文検索モジュール" +
              "PGroonga（ぴーじーるんが）"
          else
            product_full_label =
              "PGroonga (zero ETL fast full text search module for PostgreSQL)"
          end
          template = ERB.new(File.read(template_path))
          template.filename = template_path
          content = template.result(binding)
          path = "#{locale}/_posts/#{post_md}"
          File.open(path, "w") do |post|
            post.write(content)
          end
          sh("git", "add", path)
        end

        sh("git", "commit", "-m", "PGroonga #{version} has been released!!!")
        sh("git", "push")
      end
    end
  end
end
