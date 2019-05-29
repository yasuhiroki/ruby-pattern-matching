# 概要

現時点、Ruby の trunk に入っている *パターンマッチング* について試したものです

参考
- https://speakerdeck.com/k_tsj/pattern-matching-new-feature-in-ruby-2-dot-7
- https://developer.feedforce.jp/entry/2019/05/17/110000
- https://makicamel.hatenablog.com/entry/2019/05/07/044027
- https://medium.com/@baweaver/ruby-2-7-pattern-matching-first-impressions-cdb93c6246e6
- https://medium.com/@baweaver/ruby-2-7-pattern-matching-destructuring-on-point-90f56aaf7b4e

# 準備

Ruby の 2.7.0-dev をインストール
今回は [asdf](https://github.com/asdf-vm/asdf) を使用

```bash
asdf install ruby 2.7.0-dev
```

# パターンマッチングの書き方

```ruby
case A
in B
  :somthing
else
  :something
end
```

`case ~ in` 記法なんて呼ばれるかもなぁ

# ワクワクするポイント

## 新しい書き方

例) 特定の人物の性別が知りたい

```ruby
arr = [
  { name: :marty,    sex: :male   },
  { name: :doc,      sex: :male   },
  { name: :biff,     sex: :male   },
  { name: :lorraine, sex: :female }
]

# for-in でベタベタに
for val in arr
  case val[:name]
  when :marty
    p val[:sex]
  end
end

# find で抽出
p arr.find { |val| val[:name] == :marty }[:sex]

# case-in
case arr
in [{name: :marty, sex: sex}, *]
  p sex
else
end
```

## Hashの部分一致

```ruby
class Person
  def self.find_by(name:)
    case name
    when :marty
      { name: :marty, sex: :male, age: 17 }
    when :doc
      { name: :doc, sex: :male, age: 65 }
    when :biff
      { name: :biff, sex: :male, age: 48 }
    when :lorraine
      { name: :lorraine, sex: :female, age: 47 }
    end
  end
end

p = Person.find_by(name: :marty)
case p[:sex]
when :male
  p 'man'
when :female
  p 'woman'
end

case Person.find_by(name: :marty)
in { sex: :male }
  p 'man'
in { sex: :female }
  p 'woman'
end


p = Person.find_by(name: :marty)
case p[:sex]
when :male
  p p[:age] < 20 ? 'young man' : 'man'
when :female
  p 'woman'
end

if p[:sex] == :female
  p 'woman'
elsif p[:sex] == :male
  p p[:age] < 20 ? 'young man' : 'man'
end

case Person.find_by(name: :marty)
  in { sex: :male, age: 0..20 }
  p 'young man'
in { sex: :male }
  p 'man'
in { sex: :female }
  p 'woman'
end

case Person.find_by(name: :marty)
in { sex: :male, age: age } if age < 20
  p 'young man'
in { sex: :male }
  p 'man'
in { sex: :female }
  p 'woman'
end
```

## ActiveRecord で妄想

### type によって処理変える

```ruby
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
```

### body が nil かどうか

```ruby
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

def ex_action2(person_action)
  case person_action
  in { body: nil }
    p "no message"
  in { body: }
    p "Message #{body}"
  end
end

person_actions.each { |pa| ex_action2(pa) }
```

TODO: これだ！ という用途を見つけたい

## JSON

./sample/07_json.rb 参考


## Benchmark

```
n=0
        user     system      total        real
value  0.000006   0.000002   0.000008 (  0.000005)
regexp  0.000003   0.000001   0.000004 (  0.000003)
lambda  0.000003   0.000001   0.000004 (  0.000003)
if  0.000003   0.000001   0.000004 (  0.000003)
when  0.000003   0.000001   0.000004 (  0.000004)

n=1000
        user     system      total        real
value  0.001582   0.000004   0.001586 (  0.001590)
regexp  0.001429   0.000013   0.001442 (  0.001458)
lambda  0.001830   0.000024   0.001854 (  0.001890)
if  0.000959   0.000001   0.000960 (  0.000964)
when  0.000270   0.000001   0.000271 (  0.000270)

n=100000
        user     system      total        real
value  0.062575   0.000400   0.062975 (  0.064089)
regexp  0.062607   0.000257   0.062864 (  0.063175)
lambda  0.109656   0.000450   0.110106 (  0.110594)
if  0.048184   0.000161   0.048345 (  0.048541)
when  0.014900   0.000154   0.015054 (  0.015311)

n=1000000
        user     system      total        real
value  0.479607   0.001264   0.480871 (  0.482902)
regexp  0.625591   0.001763   0.627354 (  0.630367)
lambda  1.056466   0.002309   1.058775 (  1.062169)
if  0.460018   0.001406   0.461424 (  0.463710)
when  0.140036   0.000764   0.140800 (  0.141793)
```

