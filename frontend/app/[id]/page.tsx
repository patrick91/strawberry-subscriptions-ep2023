import { PollWrapper } from "./poll-cc";

export const dynamic = "force-dynamic";

export default async function Home({ params }: { params: { id: string } }) {
  return <PollWrapper id={params.id} />;
}
