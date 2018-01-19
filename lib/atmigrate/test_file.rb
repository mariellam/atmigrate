module TestRailCsv
  class TestFile
    DEFAULT_STATUS = 'Draft'.freeze

    def initialize(path)
      @path = path
    end

    def content
      [
        title,
        description,
        preconditions,
        steps,
        status
      ]
    end

    private

    def info
      parts.first
    end

    def title
      info[0].chomp.tap { |t| t[0..1] = '' }
    end

    def description
      info[1].chomp
    end

    def preconditions
      extract_steps(parts[1]) unless parts.length == 3
    end

    def steps
      extract_steps(parts.last)
    end

    def status
      DEFAULT_STATUS
    end

    def text
      File.read(@path)
    end

    def parts
      @parts ||= lines.slice_before(/^##? /).to_a
    end

    def lines
      text.lines.reject { |line| line == "\n" || line.start_with?('<!---') }
    end

    def extract_steps(part)
      part.shift
      part.join('')
    end
  end
end
