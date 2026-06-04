# HUJI2026 Lean Workshop

This repository contains the Lean project for the Lean Workshop at the
Einstein Institute of Mathematics, Hebrew University of Jerusalem, on
June 11-12, 2026.

The goal of this README is to help you get the workshop files onto your own
computer and open them in Lean. You do not need to be a GitHub expert, and you
do not need a GitHub account just to use the files.

## What You Will Install

You will need:

1. **VS Code**, the editor we will use for Lean.
2. **The Lean 4 extension for VS Code**.
3. **Lean**, installed through Lean's version manager, `elan`.
4. **Git**, which Lean/Lake uses to download mathlib dependencies. You do not
   need to learn Git for the workshop.
5. **This repository**, downloaded from GitHub.

The official Lean installation page is here:

<https://lean-lang.org/install/>

The Lean 4 VS Code extension page is here:

<https://marketplace.visualstudio.com/items?itemName=leanprover.lean4>

## Step 1: Install VS Code

Download and install VS Code:

<https://code.visualstudio.com/>

After installing it, open VS Code once to check that it works.

## Step 2: Install the Lean 4 Extension

In VS Code:

1. Click the **Extensions** icon on the left side.
2. Search for `Lean 4`.
3. Install the extension named **Lean 4**, published by `leanprover`.

After installing the extension, VS Code should show a Lean setup guide. Follow
that guide to install Lean. If the guide does not open automatically, open a
new empty file in VS Code, click the Lean symbol in the top-right corner
(it looks like an upside-down A), and choose the setup guide from the Lean
documentation menu.

On some computers, Lean will also need Git. If you do not already have Git,
install it from:

<https://git-scm.com/downloads>

## Step 3: Download This Repository

The repository is here:

<https://github.com/AlexKontorovich/HUJI2026>

You have two good options.

### Option A: Download a ZIP File

This is the simplest option if you do not know Git.

1. Open <https://github.com/AlexKontorovich/HUJI2026>.
2. Click the green **Code** button.
3. Click **Download ZIP**.
4. Unzip the file.
5. Move the unzipped `HUJI2026` folder somewhere easy to find, such as your
   Desktop or Documents folder.

### Option B: Use Git

If you already have Git installed, open a terminal and run:

```bash
git clone https://github.com/AlexKontorovich/HUJI2026.git
cd HUJI2026
```

You do not need a GitHub account for this command.

## Step 4: Open the Folder in VS Code

Open VS Code, then choose:

```text
File > Open Folder...
```

Select the `HUJI2026` folder.

Important: open the whole `HUJI2026` folder, not just one `.lean` file. Lean
uses the project files in this folder to know which version of Lean and mathlib
to use.

If VS Code asks whether you trust the authors of the folder, choose **Yes**.

## Step 5: Download the Mathlib Cache

This project uses `mathlib`, Lean's main mathematics library. Building all of
mathlib from scratch can take a very long time, so we download precompiled
files instead.

In VS Code, open a terminal:

```text
Terminal > New Terminal
```

Make sure the terminal is inside the `HUJI2026` folder. Then run:

```bash
lake exe cache get
```

The first time you run this, Lean may also download the exact Lean version used
by this project. That is normal. This repository currently uses the Lean
toolchain written in the file `lean-toolchain`.

When the cache command finishes, run:

```bash
lake build
```

If `lake build` finishes without an error, your local copy is ready.

## Step 6: Open a Lean File

Open:

```text
HUJI2026/Basic.lean
```

At first, the file contains only:

```lean
import Mathlib
```

That line means the project has access to mathlib. When Lean is working, VS Code
will show Lean information as you move through Lean files. If there is a red
error at first, wait a moment: Lean sometimes needs time to start.

## Useful Commands

Run these commands from inside the `HUJI2026` folder.

```bash
lake exe cache get
```

Downloads precompiled mathlib files.

```bash
lake build
```

Checks that the project builds.

```bash
git pull
```

Updates your copy of the repository, if you downloaded it using Git.

If you downloaded a ZIP file, `git pull` will not work. To update, download a
fresh ZIP file from GitHub.

## Troubleshooting

### VS Code says `lake` or `lean` is not found

Lean may not have been installed yet, or your terminal may not know where `elan`
was installed. Try closing and reopening VS Code. If that does not help, open
the Lean 4 setup guide again from the Lean extension and follow the installation
steps.

### `lake exe cache get` fails

Check that:

1. You are connected to the internet.
2. You opened a terminal in the `HUJI2026` folder.
3. Git is installed on your computer.

On macOS, if a window asks you to install the "Command Line Tools", accept it.
That usually installs Git.

### Lean is slow the first time

That is normal. The first setup downloads Lean, downloads mathlib dependencies,
and starts the Lean language server. After the first setup, opening the project
should be much faster.

### You opened a `.lean` file and Lean behaves strangely

Close VS Code and reopen the whole `HUJI2026` folder using:

```text
File > Open Folder...
```

Lean projects should be opened as folders, not as isolated files.

## During the Workshop

You are encouraged to experiment. If you get stuck, it is fine to ask for help
with any of the following:

1. Opening the project in VS Code.
2. Running `lake exe cache get`.
3. Understanding a Lean error message.
4. Finding where to type your Lean code.
5. Saving your work.

The important thing is not to know everything in advance. The important thing is
to arrive with the project open in VS Code and Lean responding to the file
`HUJI2026/Basic.lean`.
