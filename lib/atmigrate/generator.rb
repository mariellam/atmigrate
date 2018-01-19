module TestRailCsv
  class Generator
    CONFIG_FILE       = 'config.yml'.freeze
    CONFIG_IGNORE_KEY = 'ignore'.freeze
    TEST_FILE_PATTERN = '**/*.md'.freeze
    CSV_HEADERS       = %w(Title Description Preconditions Steps Status).freeze
    OUTPUT_FILE       = 'master.csv'.freeze

    def self.generate
      new.generate
    end

    def generate
      CSV.open(OUTPUT_FILE, 'w', headers: CSV_HEADERS, write_headers: true) do |csv|
        paths.each { |path| csv << TestRailCsv::TestFile.new(path).content }
      end
    end

    private

    def paths
      Dir.glob(TEST_FILE_PATTERN, File::FNM_CASEFOLD).reject do |filename|
        File.directory?(filename) || File.basename(filename).start_with?(*ignored_files)
      end
    end

    def ignored_files
      YAML.load_file(CONFIG_FILE)[CONFIG_IGNORE_KEY]
    end
  end
end
