############################
######## how to use ########
#### CREATION ##############
# $ rake db:seed
#### DELETION ##############
# $ rake db:drop
############################

# question template
# 0 TEXTFIELD
# 1 CHECKBOX
# 2 RADIOBUTTO

pairs = [
  [0, "TEXTFIELD"],
  [1, "CHECKBOX"],
  [2, "RADIOBUTTON"]
]

pairs.each do |type, title|
  qt = QuestionTemplate.new(:type => type, :title => title)
  if !qt.save
    puts "#{qt.title} #{qt.errors.full_messages.to_a.to_s}"
  end
end

# survey template
pairs = [
  "DEFAULT",
]

pairs.each do |title|
  st = SurveyTemplate.new(:title => title)
  if !st.save
    puts "#{st.title} #{st.errors.full_messages.to_a.to_s}"
  end
end

# result template
pairs = [
  [0, "STICK"],
  [1, "CIRCLE"],
]

pairs.each do |type, title|
  rt = ResultTemplate.new(:type => type, :title => title)
  if !rt.save
    puts "#{rt.title} #{rt.errors.full_messages.to_a.to_s}"
  end
end
