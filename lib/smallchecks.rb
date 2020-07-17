class SmallChecks
  def check_end(line_c)
    line_c.strip == 'end'
  end

  def check_elsif_else(line_c)
    line_c.strip.split(' ')[0].eql?('elsif') || line_c.strip.split(' ')[0].eql?('else')
  end

  def check_when(line_c)
    line_c.strip.split(' ')[0].eql?('when')
  end

  def check_ident(line_c, expec_ident)
    line_c.index(/[^ ]/).eql?(expec_ident)
  end

  def check_empty(line_c)
    line_c.blank?
  end

  def check_ident_end(line_c, expec_ident)
    line_c.index(/[^ ]/).eql?(expec_ident.zero? ? 0 : expec_ident - 2)
  end

  def block_status_check(control_instance)
    control_instance.reserved_words_count <=> control_instance.end_count
  end

  def consec?(line_n, index)
    (line_n[index + 1] - line_n[index]).eql?(1)
  end
end

class String
  def blank?
    strip.empty?
  end
end