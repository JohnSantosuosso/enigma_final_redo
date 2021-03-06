module Creatable
#Key creatables
  def generate_key(key)
    key.nil? == true ? generate_new_key : @key = key
  end

  def generate_new_key
    @key = (0..9).to_a.sample(5).join
  end

#Date creatables
  def generate_date(date)
    date.nil? == true ? generate_new_date : @date = date
  end

  def generate_new_date
    @date = Time.now.strftime('%m/%d/%Y').sub('20','')
    @date.gsub!('/', '').to_s[-4..-1]
  end

#Alphabet creatables
  def generate_alphabet
    @alphabet = Hash[('a'..'z').to_a.zip((1..26).to_a)]
    @alphabet[" "] = 27
  end

#Message creatables
  def generate_message(message)
    generate_alphabet
    @message = message.downcase.chars
    @message.map! do |letter|
      if @alphabet.has_key?(letter)
        @alphabet[letter]
      else
        @alphabet[letter] = letter
      end
    end
  end

  def generate_formatted_message
    @formatted_message = @message.each_slice(4).to_a
  end

  def generate_final_message_form
    @formatted_message.map!{|x|x.nil? ? " ":x}
    @final_message_form = @formatted_message.join
  end

  def generate_alphanumeric_replacements
    generate_alphabet
    @formatted_message = @formatted_message.map! {|number| number.class == Integer ? @alphabet.key(number) : number}
  end

#Shift creatables
  def generate_shifts
    keys = []
    @key.chars.each_cons(2){|num| keys << num}
    dates = (@date.to_i ** 2).to_s[-4..-1].chars
    keys.map! {|key| key.join}
    dates.map!{|date| date.to_i}
    keys.map!{|key| key.to_i}
    @shifts = keys.zip(dates)
    @shifts.map!{|shift| shift.sum}
  end

end
