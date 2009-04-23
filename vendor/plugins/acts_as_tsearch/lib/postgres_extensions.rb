#partially from http://www.height1percent.com/articles/category/postgresql

module ActiveRecord
  module ConnectionAdapters

    class PostgreSQLAdapter < AbstractAdapter
      
      def native_database_types
        {
          :primary_key => "serial primary key",
          :string      => { :name => "character varying", :limit => 255 },
          :text        => { :name => "text" },
          :integer     => { :name => "integer" },
          :float       => { :name => "float" },
          :decimal     => { :name => "decimal" },
          :datetime    => { :name => "timestamp" },
          :timestamp   => { :name => "timestamp" },
          :time        => { :name => "time" },
          :date        => { :name => "date" },
          :binary      => { :name => "bytea" },
          :boolean     => { :name => "boolean" },
          :tsvector    => { :name => "tsvector"},
          :regprocedure =>{ :naem => "regprocedure"}
        }
      end
      
      
      #This is from this discussion by Craig Barber http://groups.google.com/group/acts_as_tsearch/browse_thread/thread/1fe3aaf886d7fdbe
      # This leaves only one problem with rails. The indexes method for the
      # PostgreSQLAdapter class does not support multiple schemas and will
      # break your schema.rb (and your tests) by including multiple index
      # names in a single add_index call (one for every other schema that has
      # the same table and index). I fixed this by adding the following to
      # your previous postgres_extensions.rb (in the PostgreSQLAdapter class)
      
      def indexes(table_name, name = nil) #:nodoc:
        schemas = schema_search_path.split(/,/).map { |p| quote(p) }.join(',')
        result = query(<<-SQL, name)
          SELECT i.relname, d.indisunique, a.attname
            FROM pg_class t, pg_class i, pg_index d, pg_attribute a, pg_namespace n
           WHERE i.relkind = 'i'
             AND d.indexrelid = i.oid
             AND d.indisprimary = 'f'
             AND t.oid = d.indrelid
             AND t.relname = '#{table_name}'
             AND a.attrelid = t.oid
             AND n.nspname in (#{schemas})
             AND n.oid = t.relnamespace
             AND ( d.indkey[0]=a.attnum OR d.indkey[1]=a.attnum
                OR d.indkey[2]=a.attnum OR d.indkey[3]=a.attnum
                OR d.indkey[4]=a.attnum OR d.indkey[5]=a.attnum
                OR d.indkey[6]=a.attnum OR d.indkey[7]=a.attnum
                OR d.indkey[8]=a.attnum OR d.indkey[9]=a.attnum )
          ORDER BY i.relname
        SQL

        current_index = nil
        indexes = []

        result.each do |row|
          if current_index != row[0]
            indexes << IndexDefinition.new(table_name, row[0], row[1] == "t", [])
            current_index = row[0]
          end

          indexes.last.columns << row[2]
        end

        indexes
      end
    end
    
    class Column
      private
      def simplified_type(field_type)
        case field_type
          when /int/i
            :integer
          when /float|double/i
            :float
          when /decimal|numeric|number/i
            extract_scale(field_type) == 0 ? :integer : :decimal
          when /datetime/i
            :datetime
          when /timestamp/i
            :timestamp
          when /time/i
            :time
          when /date/i
            :date
          when /clob/i, /text/i
            :text
          when /blob/i, /binary/i
            :binary
          when /char/i, /string/i
            :string
          when /boolean/i
            :boolean
          when /tsvector/i
            :text
          when /regprocedure/i
            :string
        end
      end    
    end
  end

end


