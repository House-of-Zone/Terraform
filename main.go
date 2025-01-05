package main

import (
	"log"
	"context"
	"github.com/House-of-Zone/Terraform"
)

func handler(ctx context.Context) error {
	log.Print("Golang lambda executed via EventBridge Cron") 
	return nil
}
func mm() {
	lambda.Start(handler)
}	