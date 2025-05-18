# Tokenized Supply Chain Financing

A blockchain-based system for supply chain financing using Clarity smart contracts on the Stacks blockchain.

## Overview

This project implements a tokenized supply chain financing system that allows suppliers to receive early payment for their invoices. The system uses blockchain technology to ensure transparency, security, and trust between all parties involved.

## System Components

### 1. Supplier Verification Contract

The Supplier Verification Contract handles the registration and validation of suppliers in the system.

Key functions:
- `register-supplier`: Allows a supplier to register in the system
- `verify-supplier`: Admin function to verify a supplier's credentials
- `is-verified-supplier`: Checks if a supplier is verified

### 2. Buyer Verification Contract

The Buyer Verification Contract handles the registration and validation of buyers in the system.

Key functions:
- `register-buyer`: Allows a buyer to register in the system
- `verify-buyer`: Admin function to verify a buyer's credentials
- `is-verified-buyer`: Checks if a buyer is verified

### 3. Invoice Verification Contract

The Invoice Verification Contract records and validates invoice information between suppliers and buyers.

Key functions:
- `create-invoice`: Creates a new invoice record
- `verify-invoice`: Verifies an invoice (by admin or buyer)
- `mark-invoice-paid`: Marks an invoice as paid
- `get-invoice`: Retrieves invoice details

### 4. Credit Risk Assessment Contract

The Credit Risk Assessment Contract evaluates and scores the payment reliability of entities in the system.

Key functions:
- `set-credit-score`: Sets a credit score for an entity (admin only)
- `get-credit-score`: Retrieves the credit score of an entity
- `is-creditworthy`: Checks if an entity is creditworthy

### 5. Funding Contract

The Funding Contract manages the early payment financing process.

Key functions:
- `request-funding`: Creates a funding request for an invoice
- `approve-funding`: Approves a funding request (admin only)
- `fund-request`: Funds an approved request
- `mark-funding-repaid`: Marks a funding as repaid
- `get-funding-request`: Retrieves funding request details

## How It Works

1. Suppliers and buyers register in the system
2. Admin verifies suppliers and buyers
3. Suppliers create invoices for goods/services provided to buyers
4. Buyers verify invoices
5. Suppliers can request early payment financing for verified invoices
6. Admin approves funding requests based on credit assessment
7. Funders provide early payment to suppliers
8. Buyers pay the full invoice amount at the due date
9. Funders mark the funding as repaid

## Development

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) - Clarity development environment
- [Node.js](https://nodejs.org/) - For running tests

### Testing

Tests are written using Vitest. To run the tests:

\`\`\`bash
npm install
npm test
\`\`\`

## Security Considerations

- Admin keys should be properly secured and potentially managed through multi-signature arrangements
- Credit scoring should be based on reliable data sources
- Proper error handling is essential to prevent unexpected behavior

## License

This project is licensed under the MIT License - see the LICENSE file for details.
