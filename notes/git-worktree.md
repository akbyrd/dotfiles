Commands
--------
* Basic setup (no-checkout)
	```pwsh
	git clone --no-checkout --config core.bare=true <repo>

	cd <dir>
	git add worktree self main
	git add worktree agent -b agent-feature
	```

* Could also do it with --bare, but requires extra steps
	```pwsh
	git clone --bare <repo> <dir>/.git
	cd <dir>
	git config core.logallrefupdates true
	git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
	git fetch --all
	git pack-refs --all
	git update-server-info
	```


Resources
---------
[Tutorial](https://www.youtube.com/playlist?list=PL4cUxeGkcC9iUtQh7Aja3TGfbdd7Z-K0W)
[Test repo](https://github.com/iamshaunjp/portfolio-worktrees#)
