require "string"

module Ti
  module Sdoc
    module Parser
      def self.parse(data)
        api = []

        data.each do |key, values|
          block = {
            :id => key,
            :description => values["description"].to_s.strip.gsub(/[\n]/, "\n * ").strip_tags.capitalize,
            :deprecated => values["deprecated"],
            :compat => values["platforms"].to_a.map{|c| c.capitalize}.join("|"),
            :code => [],
            :since => values["since"],
            :type => values["returns"].to_s.split(",").map{|c| c.capitalize}.join("|")
          }

          if !values["examples"].empty?
            values["examples"].each do |e|
              block[:code].push({
                :code => e["code"].to_s.strip.gsub(/[\n]/, "\n * "),
                :description => e["description"].strip.gsub(/[\n|\t|\r]/, "").gsub(/[\s]{2,}/, " ").strip_tags
              })
            end
          end

          api.push(block)

          if !values["methods"].empty?
            values["methods"].each do |m|
              block = {
                :id => "#{key}.#{m["name"]}",
                :description => m["value"].to_s.strip.gsub(/[\n]/, "\n * ").strip_tags.capitalize,
                :deprecated => m["deprecated"],
                :type => m["returntype"].to_s.split(",").map{|c| c.capitalize}.join("|"),
                :parameters => [],
                :since => m["since"]
              }

              if m["parameters"]
                m["parameters"].each do |p|
                  block[:parameters].push({
                    :name => p["name"],
                    :description => p["description"].strip.gsub(/[\n|\t|\r]/, "").gsub(/[\s]{2,}/, " ").strip_tags,
                    :type => "{#{p["type"].capitalize}}"
                  })
                end
              end

              api.push(block)
            end
          end

          if !values["properties"].empty?
            values["properties"].each do |p|
              block = {
                :id => "#{key}.#{p["name"]}",
                :description => p["value"].to_s.strip.gsub(/[\n]/, "\n * ").strip_tags.capitalize,
                :deprecated => p["deprecated"],
                :type => p["type"].to_s.split(",").map{|c| c.capitalize}.join("|"),
                :property => true,
                :since => p["since"]
              }
              
              api.push(block)
            end
          end
        end

        api
      end
    end
  end
end
