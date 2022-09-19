describe('Jungle Rails Product Details', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  })

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  })

  it("goes to the product detail page when clikced", () => {
   // Clicks on the product in the products 
   cy.get(".products article").first().click();
   // Sees the booked appointment
   cy.contains(".products-show", "Scented Blade");
  })

  // OR 

  it("There is product detail on the page", () => {
    cy.get(".products article").first().click();
    cy.get("article.product-detail").should("be.visible");
  })

})