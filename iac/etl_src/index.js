// NOTE: You do not need to include the node_modules folder when you manually upload code as a .zip file—you can successfully deploy your function without the the node_modules folder.
exports.handler = (req, res) => {
  let message = req.query.message || req.body.message || "World"
  res.status(200).send(`Hello ${message}!`);
};
