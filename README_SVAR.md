# README_SVAR - DevOps Eksamen, Kandidat 27

# Oppgave 1, Terraform, S3 og infrastruktur

## Leveranser

 - Terraform koden min ble skrevet i mappen: **`infra-s3/`**
 - Workflow for terraform: **`.github/workflows/terraform-s3.yml`**
 - Opprettet S3-bucket: **`kandidat-27-data` (region: `eu-west-1`)**
 - Lifecycle-regel opprettet for prefix **`midlertidig`**
 - Public Access Block aktivert (alle 4 er satt til true)

### Validerer AWS credentials og eksporterer de
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- AWS_REGION (bruker eu-west-1 her)

### Initialiserer Terraform
`Terraform init` blir kjørt for å gjøre følgende steg:

- Laste ned AWS-provider
- Koble til backend (`pgr301-terraform-state`)

### Apply terraform
- `terraform fmt`: rydder koden
- `terraform validate`: sjekker om koden stemmer
- `terraform plan`: viser hva terraform gjør
- `terraform apply`: kjører de faktiske endringene opp mot s3 bucket

Min s3 bucket: **`kandidat-27-data`** (region: `eu-west-1`)


### Lifecycle

- **Prefix:** `midlertidig/`
- **Transition:** Flyttes til Glacier etter 30 dager
- **Expiration:** Blir slettet etter 90 dager
- **Rule ID:** `temporary-files-lifecycle`

### Public access Block:
Alle satt til **Enabled**:
- BlockPublicAcls
- IgnorePublicAcls
- BlockPublicPolicy
- RestrictPublicBuckets


# Oppgave 2 - AWS Lambda, SAM og GitHub Actions

### Del A - Deploy og test SAM-applikasjon

Hentet riktig python versjon med docker (manglet Python 3.11 lokalt), og deretter bydge den med: `sam build --use-container`

 - Kjørte lambda-funksjonen: `sam local invoke SentimentAnalysisFunction -e .\sample_event.json`
 - Funksjonen returnerte forventet JSON output, som viste at tden ble lagret i S3 bucket: `s3_location`
 - Deployet applikasjonen med: `sam deploy --guided`

### Verifisering at applikasjon skrev til s3

Jeg fikk problemer ved å teste API-et med: `curl -X POST https://YOUR-API-URL/analyze \H "Content-Type: application/json"
-d '{"text": "Apple launches groundbreaking new AI features while Microsoft faces security concerns in their cloud platform."}'`

Så jeg brukte heller isteden: 
 - `$uri = "https://mp9i0wzr7i.execute-api.eu-west-1.amazonaws.com/Prod/analyze/"`
 - `$body = @{ text = "Dette er en testmelding fra PowerShell via Invoke-RestMethod" } | ConvertTo-Json`
 - `$headers = @{ "Content-Type" = "application/json" }`
 - `$response = Invoke-RestMethod -Method Post -Uri $uri -Headers $headers -Body $body`
 - `$response | ConvertTo-Json -Depth 5`

### Leveranser

 - **API Gateway URL:**
   `https://mp9i0wzr7i.execute-api.eu-west-1.amazonaws.com/Prod/analyze/ `
 - **S3 objekt:**
    `"s3://kandidat-27-data/midlertidig/comprehend-20251118-085214-6c32287c.json"`

### Del B - Fiks Github Actions workflow

### Leveranser





