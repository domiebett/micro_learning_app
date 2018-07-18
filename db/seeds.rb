require_relative('../app/models/category')
require_relative('../app/models/topic')

Category.create(name: 'programming', description: 'description')
programming = Category.find_by(name: 'programming')
Category.create(name: 'hacking', description: 'description')
hacking = Category.find_by(name: 'hacking')
Category.create(name: 'philosophy', description: 'description')
philosophy = Category.find_by(name: 'philosophy')

programming.topics.create(name: 'ruby')
programming.topics.create(name: 'python')
programming.topics.create(name: 'java')
programming.topics.create(name: 'go')

hacking.topics.create(name: 'metasploit')
hacking.topics.create(name: 'ping')
hacking.topics.create(name: 'nmap')

philosophy.topics.create(name: 'evolution')
philosophy.topics.create(name: 'religion')
philosophy.topics.create(name: 'love')
