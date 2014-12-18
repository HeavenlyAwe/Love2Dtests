
========================================================================================
	Test project for learning lua-scripting and Löve2D engine
========================================================================================


	1. Install Löve2D from the love2d.org website.

	2. The wikipage: https://www.love2d.org/wiki/Main_Page, has a lot of tutorials


Just zip the contents of src folder and (so that the main.lua is in the root of the zip) and run it by from the terminal with:

	path_to_love/love [project_name].love
	path_to_love/love --console [project_name].love

Or run the "folder" itself directly:

	path_to_love/love src
	path_to_love/love --console src
	


========================================================================================
	ECLIPSE (Luna)
========================================================================================

The project is done with Eclipse and "Koneki LDT" Lua plugin. The reason is that you get auto-complete and other neat features of the IDE.


To be able to run the code from the IDE, you'll have to create a runtime configuration:


	1. Click on the dropdown button beside the green arrow with a red box

	2. Choose "External Tools Configuration"

	3. Right click on the "Program" entry in the list on the left.

	4. Name it wathever you like (Love2D for instance).

	5. On the "Main" tab put the
		path_to_love/love.exe		in the "Location" field

		${project_loc}/src		in the "Working Directory"

		--console ${project_loc}/src	in the "Arguments"

	5 To enable auto-complete (for Love 0.9.1)
		Include the LOVELuaDoc-master.zip in the root of the project
		It's easiest to find there.
		
		Right click on the project in the "Script Explorer" and select properties

		Lua -> Build Path -> Libraries
			Add ZIPs... and select the LOVELuaDoc-master.zip and press OK



========================================================================================
	Other text editors
========================================================================================

Read the Wiki for more information about getting started with other kinds of editors. But an editor with possiblities for "program execution" is strongly recommended!















