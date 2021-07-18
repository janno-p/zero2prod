CREATE TABLE subscriptions_tokens(
    subscription_token TEXT NOT NULL PRIMARY KEY,
    subscriber_id UUID NOT NULL REFERENCES subscriptions (id)
)