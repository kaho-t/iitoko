# frozen_string_literal: true

module ActiveStorageValidations
  class ContentTypeValidator < ActiveModel::EachValidator # :nodoc:
    def validate_each(record, attribute, _value)
      return true if !record.send(attribute).attached? || types.empty?

      files = Array.wrap(record.send(attribute))

      errors_options = { authorized_types: types_to_human_format }
      errors_options[:message] = options[:message] if options[:message].present?

      files.each do |file|
        next if is_valid?(file)

        errors_options[:content_type] = content_type(file)
        record.errors.add(attribute, :content_type_invalid, **errors_options)
        break
      end
    end

    def types
      (Array.wrap(options[:with]) + Array.wrap(options[:in])).compact.map do |type|
        if type.is_a?(Regexp)
          type
        elsif type.is_a?(String) && type =~ %r{\A\w+/[-+.\w]+\z} # mime-type-ish string
          type
        else
          Mime[type] || raise(ArgumentError, "content_type must be one of Regxep,"\
          " supported mime types (e.g. :png, 'jpg'), or mime type String ('image/jpeg')")
        end
      end
    end

    def types_to_human_format
      types
        .map { |type| type.to_s.split('/').last.upcase }
        .join(', ')
    end

    def content_type(file)
      file.blob.present? && file.blob.content_type
    end

    def is_valid?(file)
      file_type = content_type(file)
      types.any? do |type|
        type == file_type || (type.is_a?(Regexp) && type.match?(file_type.to_s))
      end
    end
  end
end
