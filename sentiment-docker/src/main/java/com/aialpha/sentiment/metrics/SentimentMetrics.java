package com.aialpha.sentiment.metrics;

import io.micrometer.core.instrument.Counter;
import io.micrometer.core.instrument.Gauge;
import io.micrometer.core.instrument.MeterRegistry;
import io.micrometer.core.instrument.Timer;
import org.springframework.stereotype.Component;

import java.time.Duration;
import java.util.concurrent.atomic.AtomicInteger;

@Component
public class SentimentMetrics {

    private final MeterRegistry meterRegistry;

    private final AtomicInteger companiesDetected = new AtomicInteger(0);

    // Constructor injection of MeterRegistry
    public SentimentMetrics(MeterRegistry meterRegistry) {
        this.meterRegistry = meterRegistry;

        meterRegistry.gauge("sentiment.companies.detected", companiesDetected);

        /**
         * Example implementation: Counter for sentiment analysis requests
         * This counter tracks the total number of sentiment analyses by sentiment type and company
         */
    }


    public void recordAnalysis(String sentiment, String company) {
        Counter.builder("sentiment.analysis.total")
                .tag("sentiment", sentiment)
                .tag("company", company)
                .description("Total number of sentiment analysis requests")
                .register(meterRegistry)
                .increment();
    }

    // Time taken to calculate how long it takes to communicate with AWS Bedrock API
    // It collects number of incidents and measurements of time to calculate the average

    public void recordDuration(long milliseconds, String company, String model) {
        Timer.builder("sentiment.bedrock.duration")
                .tag("company", company)
                .tag("model", model)
                .description("The time taken until the sentiment has been analyzed using AWS Bedrock")
                .register(meterRegistry)
                .record(Duration.ofMillis(milliseconds));

    }

    // Represents the number of companies that was found in the last analysis
    // This can go down and up over time, compared to counter

    public void recordCompaniesDetected(int count) {
        companiesDetected.set(count);
    }

    public void recordConfidence(double confidence, String sentiment, String company) {
        // TODO: Record distribution summary
    }
}
