bucket         = "terraform-up-and-running-state"
key            = "env:/terraform.tfstate"
region         = "us-east-1"  # ← Corrigé ici
use_lockfile   = true         # ← Utilisé à la place de dynamodb_table (optionnel)