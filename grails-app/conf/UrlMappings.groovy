class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}
                "/"(controller:'dashboard', action:"/index")
		//"/"(view:"/index")
		"500"(view:'/error')
                "405"(controller:'dashboard', action:"/index")
	}
}
