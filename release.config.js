module.exports = {
    branches: "main",
    repositoryUrl: "https://github.com/traliach/S3_backend_Repo.git",
    plugins: [
        '@semantic-release/commit-analyzer',
        '@semantic-release/release-notes-generator',
        '@semantic-release/git',
        '@semantic-release/github'
    ]
}
