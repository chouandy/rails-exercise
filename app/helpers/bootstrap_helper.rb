module BootstrapHelper
  #############
  ### ICONS ###
  #############

  # Generates an icon.
  def bs_icon(icon, options = {}, tag = :span)
    icon = %(glyphicon glyphicon-#{icon})
    add_css_class(icon, options)
    content_tag(tag, '', options)
  end

  ###############
  ### BUTTONS ###
  ###############

  # Generates a button.
  def button(label = 'Button', options = {})
    html_button(label, options)
  end

  # Generates a html submit button.
  def html_button(label = 'Button', options = {})
    btn(:html_button, label, options)
  end

  # Generates a submit button.
  def submit_button(label = 'Submit', options = {})
    btn(:submit_button, label, options)
  end

  # Generates a reset button.
  def reset_button(label = 'Reset', options = {})
    btn(:reset_button, label, options)
  end

  # Generates an image submit button.
  def image_button(src, options = {})
    btn(:image_button, src, options)
  end

  # Generates a link submit button.
  def link_button(label = 'Submit', options = {})
    btn(:link_button, label, options)
  end

  # Generates a input button.
  def input_button(label = 'Button', options = {})
    btn(:input_button, label, options)
  end

  # Generates a input submit button.
  def input_submit(label = 'Submit', options = {})
    btn(:input_submit, label, options)
  end

  # Generates a button.
  def btn(type, label, options = {})
    add_css_class('btn', options)

    color = pop_value(:color, options, 'default')
    add_css_class(%(btn-#{color}), options) if color

    size = pop_value(:size, options)
    add_css_class(%(btn-#{size}), options) if size

    block = pop_value(:block, options)
    add_css_class('btn-block', options) if block

    add_active_class(options)

    icon = pop_value(:icon, options)
    unless type.to_s.include?('input')
      if icon
        label = fa_icon(icon) + ' ' + label
      end
    end

    create_button(type, label, options)
  end

  def create_button(type, label, options)
    url = pop_value(:url, options, '#')
    case type
    when :html_button
      options[:type] = :button unless options[:type]
      button_tag(label, options)
    when :submit_button
      options[:name] = nil
      options[:type] = :submit
      button_tag(label, options)
    when :reset_button
      options[:name] = nil
      options[:type] = :reset
      button_tag(label, options)
    when :link_button
      options[:role] = :button
      link_to(label, url, options)
    when :input_button
      options[:value] = label
      options[:type] = :button
      tag('input', options)
    when :input_submit
      submit_tag(label, options)
    else
      # type code here
    end
  end

  ##############
  ### IMAGES ###
  ##############

  # Generates an responsive-friendly image tag
  def image_responsive(source, options = {})
    add_css_class('img-responsive', options)
    image_tag(source, options)
  end

  # Generates an image tag with rounded corners.
  def image_rounded(source, options = {})
    add_css_class('img-rounded', options)
    image_tag(source, options)
  end

  # Generates an image tag with circle.
  def image_circle(source, options = {})
    add_css_class('img-circle', options)
    image_tag(source, options)
  end

  # Generates an image tag within thumbnail.
  def image_thumbnail(source, options = {})
    add_css_class('img-thumbnail', options)
    image_tag(source, options)
  end

  #################
  ### UTILITIES ###
  #################

  # Appends new class names to the given options.
  def add_css_class(class_names, options)
    class_names = class_names.to_s if class_names.is_a?(Symbol)
    class_names = class_names.split if class_names.is_a?(String)
    if symbolize_keys(options).key?(:class)
      options_class_names = options[:class].split
      class_names.each do |value|
        options_class_names << %(#{value.strip}) unless options_class_names.include?(value)
      end
      class_names = options_class_names
    end
    options[:class] = %(#{class_names * ' '})
  end

  # Adds the pull class to the given options is applicable.
  def add_pull_class(options)
    pull = pop_value(:pull, options)
    add_css_class(%(pull-#{pull}), options) if pull
  end

  # Adds the text align class to the given options if applicable.
  def add_align_class(options)
    align = pop_value(:align, options)
    add_css_class(%(text-#{align}), options) if align
  end

  # Adds the text transform class to the given options if applicable.
  def add_transform_class(options)
    transform = pop_value(:transform, options)
    add_css_class(%(text-#{transform}), options) if transform
  end

  # Adds the color to the given options if applicable.
  def add_color_class(options)
    color = pop_value(:color, options)
    add_css_class(%(text-#{color}), options) if color
  end

  # Adds the bgcolor to the given options if applicable.
  def add_bgcolor_class(options)
    bgcolor = pop_value(:bgcolor, options)
    add_css_class(%(bg-#{bgcolor}), options) if bgcolor
  end

  # Adds the active to the given options if applicable.
  def add_active_class(options)
    active = pop_value(:active, options)
    add_css_class('active', options) if active
  end

  def normalize_typography_options(options)
    add_pull_class(options)
    add_align_class(options)
    add_transform_class(options)
    add_color_class(options)
    add_bgcolor_class(options)
  end

  ################
  ### OVERRIDE ###
  ################

  # override rails helper: content_tag
  def content_tag(name, content_or_options_with_block = nil, options = nil, escape = true, &block)
    if block_given?
      options = content_or_options_with_block if content_or_options_with_block.is_a?(Hash)
      normalize_typography_options(options) unless options.nil?
      content_tag_string(name, capture(&block), options, escape)
    else
      normalize_typography_options(options) unless options.nil?
      content_tag_string(name, content_or_options_with_block, options, escape)
    end
  end
end
