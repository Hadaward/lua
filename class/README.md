As experienced programmers working with Lua are well aware, there is no native method of creating classes in Lua, your best option is to use metatables or factory-like. However, I challenged myself to create a simple module that allows the creation of elegant classes that support python-based private variables.

- Below is an example of how to use it:
```Lua
local class = require("./class")

-- Here a simple test, we create the Person class that defines a global variable name
-- and a private variable __createdAt that refers to the creation date.

local Person = class(function(self)
	self.__createdAt = os.time()
	self.name = ""
	
	-- The main function, which will always be called at the beginning of a new instance,
	-- which receives the parameter "name".
	function self:main(name)
		-- Sets the value of name on instance to the value of the parameter.
		self.name = name
	end
	
	-- A function that serves to return the value of the private variable __createdAt
	function self:getCreatedAt()
		return self.__createdAt
	end
	
	function self:setCreatedAt(value)
		self.__createdAt = value
	end
end)

-- Instance the Person class with the name "Andrew".
local person1 = Person("Andrew")

-- Attempts to access the __createdAt private variable from outside the class
-- and tries to set a value to it. It doesn't return an error but it doesn't make any changes.
person1.__createdAt = 12

-- Prints the person's name -> 'Andrew'.
print('name:', person1.name)

-- Trying to access the value of the __createdAt variable directly. -> 'nil'
print('direct:', person1.__createdAt)

-- Trying to use getter method for __createdAt. -> 'time : number'
print('getter:', person1:getCreatedAt())

-- Trying to use the setter method for __createdAt
person1:setCreatedAt(100)

-- getter method for __createdAt. -> '100'
print('getter:', person1:getCreatedAt())
```
