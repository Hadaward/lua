-- Since there is no built-in, let's use a function to create new classes
-- Parameter n: Function(instance : table)

function class(n)
	-- Returns another function that will serve as a constructor, the basis for initializing a new instance.
	-- Parameter ...: table - vararg to receive all parameters
	
	return function(...)
		-- The table that will store all class data, including methods.
		local data = {}
		
		-- Here we create a Metatable that will generate the expected behavior of a class system
		local instance = setmetatable({}, {
			-- Metamethod fired every time a new variable is added to the table.
			
			-- Note that as its first argument, setmetatable takes an empty table, 
			-- so every time the programmer changes the value of a variable this function will be called
			-- because the values are being written to "data" table.
			
			__newindex = function(_, index, value)
				-- Variables with the "__" prefix are defined as private variables, only accessible inside classes,
				-- the expression below takes care of checking if the variable is private or not,
				-- besides checking if it is being accessed inside the class or outside.
				
				-- Note: main refers to scope outside the class.
				
				if (index:sub(1, 2) == "__" and debug.getinfo(2).what == "main") then
					return nil
				end
				
				-- If everything is ok, save changes in data table.
				data[index] = value
			end,
			
			-- Metamethod fired every time a table index is accessed.
			
			__index = function(_, index)
				if (index:sub(1, 2) == "__" and debug.getinfo(2).what == "main") then
					return nil
				end
				
				-- If everything is ok, returns the index value within the data table.
				return data[index]
			end
		})
		
		-- Call our constructor to define our instance's default variables.
		n(instance)
		
		-- Fires the "main" function with the arguments passed to the constructor.
		instance:main(...)
		
		-- returns the instance of the class.
		return instance
	end
end

return class