const MyToken = artifacts.require('MyToken');

contract('MyToken', () => {
  it('should return Token Name', async () => {
    const mytoken = await MyToken.deployed();
    const result = await mytoken.getName();
    assert(result === 'FarhanCoins');
  });
  it('should return Totall Supply', async() => {
      const mytoken =await MyToken.deployed();
      const result = await mytoken.getTotalSupply();
      assert(Number(result)===10000);
  })
});
