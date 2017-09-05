# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

a=Campaign.search(
body:{
  query:{
    bool:{
      should:[
        {
          match:{
            name:{
              query: q,
              boost: 3
            }
          }
        },

        {
          match:{
            campaign_type:{
              query: q,
              boost: 3
            }
          }
        },

        {
          range:{
            created:{
              lt: d,
              boost: 3
            }
          }
        }
      ]
    }
  }
})
a.results.count

Campaign.search(body:{query:{range:{created_at:{lt: d}}}}).results.pluck(:name)
Campaign.search("campaiGN13", where: {campaign_type: "camp_a"}).results.count
Campaign.search("campaign13", match: :phrase).results.pluck(:name).uniq
Campaign.search(where: {contact_name: "PuneetG"}).results[0].lists.map{|a| a.contacts}
Campaign.search(where: {name: /.*"campaign12".*/, campaign_type: "camp_a"}).results.count
Campaign.search("puneet ms", operator: "or").results.count

a=Campaign.search(
body:{
  query:{
    bool:{
      should:[
        {
          match:{
            name:{
              query: q,
              boost: 3
            }
          }
        },

        {
          match:{
            campaign_type:{
              query: q,
              boost: 3
            }
          }
        },

        {
          match:{
            list_name:{
              query: q,
              boost: 3
            }
          }
        }
      ]
    }
  }
})
a.results.count

a=Campaign.search(
body:{
    query: {
        constant_score: {
          filter:{ 
            bool: {
                should:[
                  {term: { list_name: q }},
                ]
            }
          }  
        }
    }
})
a.results.count
https://www.webascender.com/blog/rails-elasticsearch-searchkick-depth/