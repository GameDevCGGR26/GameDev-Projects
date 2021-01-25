
Person = {}
Person.__index = Person

function Person.new (name)
local  instance = setmetatable ({}, Person)
instance.name = name
return instance
  -- body...
end

function Person:displayName ()
print(self.name)
end

person1 = Person.new("Cesca")
person2 = Person.new("Che")
person3 = Person.new("Jorel")

person1:displayName()
person2:displayName()
person3:displayName()
