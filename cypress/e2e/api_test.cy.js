// cypress/integration/api_test.js

describe('API Test for Lambda Function', () => {
    const apiUrl = 'https://ppf34enmbe.execute-api.us-east-2.amazonaws.com/prod';
  
    it('should return status 200 and correct message for POST method', () => {
      cy.request({
        method: 'POST',
        url: `${apiUrl}/visits`, // This is your endpoint path
        headers: {
          'Content-Type': 'application/json',
        },
        body: {} // Include any required request body if necessary
      }).then((response) => {
        expect(response.status).to.eq(200);
        expect(response.body).to.have.property('message').and.match(/^Visited \d+ times\.$/);
      });
    });
  });
  