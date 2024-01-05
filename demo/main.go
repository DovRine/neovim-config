package main

import (
	"fmt"
    "html/template"
	"log"
	"net/http"
	"os"
    "strings"
	"github.com/gorilla/mux"
    db "ilokit.us/billingservice/db"
    handlers "ilokit.us/billingservice/handlers"
    helpers "ilokit.us/billingservice/helpers"
    models "ilokit.us/billingservice/models"

)

func init() {
    db.ConnectDb()
}

type StaticFilesDir struct {
    Prefix string
    Path string
}

func setupStaticFiles(*r) {
    staticFilesDirs := []StaticFilesDir{
        StaticFilesDir{
            Prefix: "/billingservice/ui/create/static/",
            Path: "./ui/create/static/",
        },
        StaticFilesDir{
            Prefix: "/billingservice/ui/lib/",
            Path: "./ui/lib/",
        },
        StaticFilesDir{
            Prefix: "/billingservice/ui/update/static/",
            Path: "./ui/update/static/",
        },
    }

    for _, staticFilesDir := range staticFilesDirs {
        r.PathPrefix(staticFilesDir.Prefix).Handler(
            http.StripPrefix(
                staticFilesDir.Prefix,
                http.FileServer(http.Dir(staticFilesDir.Path)),
            ),
        )
    }
}

func main() {
    host := "billingservice"
    port := os.Getenv("PORT")

    username := strings.TrimSpace(os.Getenv("BASIC_AUTH_USERNAME"))
    password := strings.TrimSpace(os.Getenv("BASIC_AUTH_PASSWORD"))

    r := mux.NewRouter()

    r.HandleFunc("/billingservice/healthcheck/", handlers.Healthcheck).Methods("GET")
    r.HandleFunc("/billingservice/process-payment-received/", handlers.ProcessPaymentReceived).Methods("POST")

    // NOTE: BillingService UI
    setupStaticFiles(r)

    r.PathPrefix("/billingservice/ui/create/").HandlerFunc(
        func(w http.ResponseWriter, r *http.Request){
            if helpers.BasicAuth(w, r, username, password, "Please login") {
                http.ServeFile(w, r, "./ui/create/index.html")
            }
        },
    )

    r.PathPrefix("/billingservice/ui/update/{schema}/").HandlerFunc(
        func(w http.ResponseWriter, r *http.Request){
            if helpers.BasicAuth(w, r, username, password, "Please login") {
                schema := mux.Vars(r)["schema"]
                // get customer data
                customer, err := db.GetCustomerBySchema(schema)
                if err != nil {
                    fmt.Println("Invalid Customer")
                    http.Error(w, "Invalid Customer", 404)
                    return
                }

                // TODO: get list of dcs
                fmt.Println(customer)
                type PageData struct {
                    Customer models.Customer
                }
                data := PageData{
                    Customer: customer,
                }
                tmpl, err := template.ParseFiles("./ui/update/index.html")
                if err != nil {
                    fmt.Println(err)
                    http.Error(w, err.Error(), 500)
                    return
                }
                err = tmpl.Execute(w, data)
                if err != nil {
                    fmt.Println(err)
                    http.Error(w, err.Error(), 500)
                    return
                }
            }
        },
    )
    r.Walk(func(route *mux.Route, router *mux.Router, ancestors []*mux.Route) error {
        tpl, err1 := route.GetPathTemplate()
        met, err2 := route.GetMethods()
        fmt.Println(tpl, err1, met, err2)
        return nil
    })
    fmt.Printf("Server listening on http://%s:%s\n", host, port)
    log.Fatal(http.ListenAndServe(fmt.Sprintf("0.0.0.0:%s", port), r))
}

