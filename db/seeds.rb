# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Item.where(name: "ExtemPrep",
           description: "A startup that provided research and news resources to high school speech and debate programs electronically by parsing every major news website and cataloging the articles. Written in Rails with a Hadoop cluster for processing.",
           has_code: false).first_or_create

Item.where(name: "Hobby Operating System",
           base_dir: "/users/rickbutton/code/os",
           description: "A hobby level operating system project, written in freestanding C and X86 assembly. Interesting features include a full static module loader and working virtual memory system, as well as a full built in custom debugger.").first_or_create

Item.where(name: "Golang Scheme Interpreter",
            base_dir: "/users/rickbutton/code/goscheme",
            description: "An (almost) R5RS compliant Scheme interpreter written in the Google Go language. This was written in order to teach myself the Go language. It's most interesting feature is the fact that the REPL is written in Scheme, not in Go.").first_or_create

Item.where(name: "Philosophie Search Challenge",
            base_dir: "/users/rickbutton/code/search_challenge",
           description: "The implementation of the philosophie/search_challenge challenge project. The notable file in this implementation is the Searchable concern in app/models/concerns.").first_or_create

Item.where(name: "Jarvis",
            base_dir: "/users/rickbutton/code/jarvis",
           description: "A Ruby based personal assistant akin to Siri or Google Now, but geared towards developers. The Jarvis system handles everything from speech recognition to meaning detection, all the way to text to speech, so that plugin developers only need to worry about the domain logic of their plugin, rather than the quirks of speech recognition and NLP.").first_or_create

Item.where(name: "Portfolio",
            base_dir: "/users/rickbutton/code/portfolio",
           description: "A portfolio specifically designed and programmed to be shown to the guys at philosophie during the technical interview. Written in Rails 4 in about three hours. A bit meta, because this website is this project.").first_or_create

admin = AdminUser.where(email: "admin@example.com").first
unless admin
  admin = AdminUser.new(email: "admin@example.com",
                        password: "password",
                        password_confirmation: "password")
  admin.save
end
