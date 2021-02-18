const MyToken = artifacts.require('MyToken');

contract("MyToken", accounts => {

  let instance =null;
  before(async() => { 
    instance = await MyToken.deployed();
  });
// Transfer From
  it("Should TranferFrom work propely" , async() => {
    let acc_one=accounts[0];
    let acc_two=accounts[1];
    let acc_three=accounts[2];
    let amount=100;
    await instance.approve(acc_two,1000);
    let allowed= await instance.allowance(acc_one,acc_two);
    let bal_before= await instance.balanceOf(acc_three);
    await instance.transferFrom(acc_two,acc_three,amount);
    let bal_after= await instance.balanceOf(acc_three);
    assert.equal(Number(allowed),1000,"User have not assigned allownce");
    assert.equal(Number(bal_after),Number(bal_before)+100,"User have recived funds");
  })
  // Check Allownce Test Case
  it("Should Allownce work properly", async() =>{
    let acc_one=accounts[0];
    let acc_two=accounts[1];
    let amount=100;
    await instance.approve(acc_two,amount);
    let allownce = await instance.allowance(acc_one,acc_two);
    assert.equal(Number(allownce),1100,"Allownce is not assigned.");
  })
  // Transfer Funtion Test
  it("Should Transfer work properly", async() => {
    let account_one = accounts[0];
    let account_two = accounts[1];
    let amount =10;
    let acc_one_sb= await instance.balanceOf(account_one);
    let acc_two_sb= await instance.balanceOf(account_two);
    await instance.transfer(account_two,amount);
    let acc_one_eb=await instance.balanceOf(account_one);
    let acc_two_eb=await instance.balanceOf(account_two);
    assert.equal(Number(acc_one_eb),Number(acc_one_sb)-amount,"Amount wasn't correctly taken from the sende");
    assert.equal(Number(acc_two_eb),Number(acc_two_sb)+amount,"Amount wasn't correctly sent to the receiver");
    })
  // GetName Test 
  it("Should getName work properly", async () => {
    const result = await instance.getName();
    assert(result === 'FarhanCoins');
  });
  // Total Supply Test
  it("Should Totally Supply work properly", async() => {
      const result = await instance.totalSupply();
      assert((result.toNumber())===10000);
  });
  // Decimal Test 
  it("Should Decimal work properly", async() => {
    const result = await instance.getDecimal();
    assert((result.toNumber())===18);
  });
});


