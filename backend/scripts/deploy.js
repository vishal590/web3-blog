async function main(){
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Account Balance:", (await deployer.getBalance()).toString());

  const blog = await ethers.getContractFactory("Blog");
  const Blog = await blog.deploy();

  console.log("Post address:", Blog.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });