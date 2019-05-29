class PersonAction
  def self.where(person_id: nil)
    [
      { type: :message, body: 'hoge' },
      { type: :message, body: 'fuga' },
      { type: :image, body: nil },
      { type: :reaction, body: nil },
      { type: :message, body: 'piyo' },
    ]
  end
end

def ex_action(person_action)
  case person_action
  in { type: :message, body: }
    p "Message #{body}"
  in { type: :image | :reaction }
    p "no message"
  end
end

person_actions = PersonAction.where(person_id: 1)
person_actions.each { |pa| ex_action(pa) }
puts


def ex_action2(person_action)
  case person_action
  in { body: nil }
    p "no message"
  in { body: }
    p "Message #{body}"
  end
end

person_actions.each { |pa| ex_action2(pa) }
