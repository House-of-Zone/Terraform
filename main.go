package main

import (
	"log"
	"context"
	"github.com/aws/aws-lambda-go/lambda"
)

func handler(ctx context.Context) error {
	log.Print("Golang lambda executed via EventBridge Cron") 
	return nil
}
func main() {
	lambda.Start(handler)
}	