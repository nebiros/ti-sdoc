module Ti
  module Sdoc
    module Builder
      def self.build(data)
        # open block.
        block = <<-BLOCK
/**
 * #{data[:description]} #{(data[:compat]) ? "Platforms: " + data[:compat] : ""}
 *
BLOCK

        if !data[:code].to_a.empty?
          block += <<-BLOCK
 * @code
BLOCK

          data[:code].each do |c|
            block += <<-BLOCK
 * #{c[:description]}:
 * #{c[:code]}
BLOCK
          end
        end

        block += <<-BLOCK
 * @id #{data[:id]}
BLOCK

        if !data[:parameters].to_a.empty?
          data[:parameters].each do |p|
            block += <<-BLOCK
 * @param #{p[:type]} #{p[:name]} #{p[:description]}
BLOCK
          end
        end
        
        if data[:type]
          block += <<-BLOCK
 * @type #{data[:type]}
BLOCK
        end

        if data[:property]
          block += <<-BLOCK
 * @property
BLOCK
        end

        if data[:since]
          block += <<-BLOCK
 * @since #{data[:since]}
BLOCK
        end

        if data[:deprecated]
          block += <<-BLOCK
 * @deprecated #{data[:deprecated]}
BLOCK
        end

        # close.
        block += <<-BLOCK
 */
BLOCK

        block
      end
    end
  end
end
